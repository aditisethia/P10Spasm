from sage.graphs.independent_sets import IndependentSets

def write_graphs(graphs, file):
    with open(file, "w") as fout:
        fout.write(r"""
        \documentclass{article}
        \usepackage{tikz,tkz-graph}
        \begin{document}
        """)
        for graph in graphs:
            fout.write(r"\begin{figure}[h]")
            graph.set_latex_options(format="dot2tex")
            fout.write(latex(graph))
            fout.write(r"\end{figure}")
            fout.write("\\clearpage\n")
        fout.write("\\end{document}")

def is_minor(g, h):
    try:
        g.minor(h)
        return True
    except ValueError:
        return False

h = Graph({
    0: [3, 4, 7, 8],
    1: [3, 4, 5, 6],
    2: [5, 6, 7, 8],
})

def non_trivial(g):
    tw = g.treewidth()
    if tw <= 1: return False
    if tw == 2 and not is_minor(g, h): return False
    return True

tbmc = [] # To be manually checked.
for e in [6,7,8,9]:
    f = open(f"graph{e}e.g6", "r")
    for G in map(Graph, f.readlines()):
        if non_trivial(G):
            tbmc.append(G)

print(f"{len(tbmc)} to be manually checked.")
write_graphs(tbmc, "allmtw9.tex")
