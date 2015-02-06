import profile

from Tree.rooted_tree import Tree

def min_length(T):
    return T.weight + min([min_length(s) for s in T.sons] or [0])

if __name__ == "__main__":
    example_1 = Tree(0,[Tree(5,[Tree(-4,[Tree(11),
                                      Tree(2)]),
                              Tree(2)]),
                      Tree(2,[Tree(5,[Tree(-2),
                                      Tree(4),
                                      Tree(7)])]),
                      Tree(1,[Tree(10)])])

    example_2 = Tree(5,[Tree(1,[Tree(-5,[Tree(7,[]),
                                         Tree(3,[])]),
                                 Tree(2,[]),
                                 Tree(11,[Tree(-5,[])])]),
                        Tree(2,[Tree(0,[Tree(12,[])])]),
                        Tree(3,[Tree(7,[Tree(2,[])]),
                                Tree(2,[])])])

    print("## Example 1:")
    print("Min length: %d" % min_length(example_1))
    print("Size: %d" % example_1.size())
    profile.run("min_length(example_1)")


    print("\n## Example 2:")
    print("Min length: %d" % min_length(example_2))
    print("Size: %d" % example_2.size())
    profile.run("min_length(example_2)")


