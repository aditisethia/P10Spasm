def write_graphs2(graphs2, file):
    with open(file, "w") as fout:
        fout.write(r"""
        \documentclass{article}
        \usepackage{tikz,tkz-graph}
        \begin{document}
        """)
        for graph1, graph2 in graphs2:
            fout.write(r"\begin{figure}[h]")
            graph1.set_latex_options(format="dot2tex")
            fout.write(latex(graph1))
            fout.write(r"\end{figure}")
            fout.write(r"\begin{figure}[h]")
            graph2.set_latex_options(format="dot2tex")
            fout.write(latex(graph2))
            fout.write(r"\end{figure}")
            fout.write("\\clearpage\n")
        fout.write("\\end{document}")

def mtd(G, vertex_picker=lambda H: H.vertices(), cutoff=0):
    """Return the mtd, list of elimination trees, and the list of roots."""
    if not G.is_connected():
        Ts = []
        us = []
        dmax = 0
        for (d, [T], [u]) in map(mtd, G.connected_components_subgraphs()):
            if d > dmax: dmax = d
            Ts.append(T)
            us.append(u)

    if G.order() == 1:
        u = G.random_vertex()
        T = DiGraph({G.random_vertex(): []})
        return (1, [T], [u])

    if G.order() == 0:
        return (0, [DiGraph()], [])


    H = G.copy()
    dmin = G.order() + 1
    for v in vertex_picker(H):
        HC = H.copy()
        HC.delete_vertex(v)
        E = DiGraph()
        E.add_vertex(v)
        m = 0
        dmax_child = 0
        for c in HC.connected_components_subgraphs():
            u = None
            for w in c:
                if G.has_edge((v, w)):
                    u = w
                    break
            c.delete_vertex(u)
            E.add_edge((u, v))
            if c.order() > 0:
                Xs = []
                def mtd_(H):
                    return mtd(H, vertex_picker=vertex_picker, cutoff=cutoff-2)
                for (d, [T], [w]) in map(mtd_, c.connected_components_subgraphs()):
                    dmax_child = max(dmax_child, d)
                    E.add_edge((w, u))
                    E = E.union(T)
        if 2+dmax_child < dmin:
            dmin = 2+dmax_child
            Emin = E
            vmin = v
        if dmin <= cutoff:
            return (dmin, [Emin], [vmin])
    return (dmin, [Emin], [vmin])

def max_degree_picker(H):
    return [max(H.vertices(), key=lambda u: H.degree(u))]

good = []

for x in [6,7,8,9,10,11]:
    f = open(f"graph{x}e.g6")
    for G in map(Graph, f.readlines()):
        d, [T], [u] = mtd(G, vertex_picker=max_degree_picker, cutoff=6)
        if d <= 6:
            good.append((G, T))
        else:
            d, [T], [u] = mtd(G, cutoff=6)
            assert d <= 6
            good.append((G, T))

print(f"{len(good)} graphs to write.")
write_graphs2(good, "allmtd6.tex")
