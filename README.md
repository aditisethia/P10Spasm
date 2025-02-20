# Spasm
Matched Treewidth <= 3 for all connected graphs with at most 9 edges:

For any graph G,
- If tw(G) = 1, then mtw(G)=1. 
- If tw(G) = 2 and there is no X-minor in G, mtw(G) = 2. 
Now we consider the remaining 33 graphs generated by matchingspasm.sage.
Since X has 12 edges, and we are considering the graphs with atmost 9 edges, so, X does not appear as an induced minor, and hence we get the graphs G with 2<tw(G)<3. By using the fact that deleting pendant vertices cannot affect the matched treewidth, we can reduce this to $11$ such graphs. For each of them, as shown in allmtw9.pdf, mtw(G)<=3.

In addition, the pdf file Spasm(P10) contains the graphs(except trees) that are homomorphic images of P10 and their respective matched tree decompositions. Every bag in the tree decomposition if of size at most 4, therefore, the matched treewidth of any graph in Spasm(P10) is 3.


Matched Treedepth <= 6 for all connected graphs with at most 11 edges:
The files "graph{x}e.g6" are graph6 encodings of all connected graphs on x edges, generated by the "geng" program, as follows:
- Install "geng" program.
- Run "geng -c n mmin:mmax <filename>" to generate all connected graphs on n vertices where the number of edges is in the range [mmin, mmax].

The file "allmtd6.pdf" contains matched elimination trees of depth at most 6 for all connected graphs on 6 to 11 edges. The program "mtd6.sage" takes the graph6 encodings and produces the above-matched elimination trees. The heuristic is as follows:
- An arbitrary max-degree vertex v is picked at each step. The elimination tree is rooted at v, and an N(v) is chosen as a child of v. Repeat the same process recursively with the remaining vertices. 
- If the above heuristic fails to show mtd ≤ 6, then compute the mtd by brute-force.
