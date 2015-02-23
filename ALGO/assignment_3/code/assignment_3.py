from Graph.graph import Arc

def min_cycle(G = []):
    if G == []:
        return 666

    arc = G.pop()
    return min(min_from(G,
                        arc.a,
                        arc.b,
                        arc.w,
                        1),
               min_cycle(G))

def min_from(G, goal, root, w, steps):
    if root == goal and w < 0:
        return steps

    if G == []:
        return 666

    results = [666]
    for arc in G:
        if arc.a == root:
            gc = G.copy()
            gc.remove(arc)
            results.append(min_from(gc, goal, arc.b, w + arc.w, steps + 1))

    return min(results)

if __name__ == "__main__":
    g1 = [Arc("a", "b", 2),
        Arc("b", "a", -5),
        Arc("a", "c", 3),
        Arc("b", "d", 5),
        Arc("c", "b", 0),
        Arc("c", "d", 1),
        Arc("d", "e", 2),
        Arc("e", "c", -4)]

    print(min_cycle(g1))
