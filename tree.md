aaaabbcddd

a: 0.4  d: 0.3  b: 0.2  c: 0.1
a: 0.4  d: 0.3  cb: 0.3
a: 0.4  dcb: 0.6

    adcb
    /   \
   a   dcb
      /   \
     d    cb
         /  \
        c    b

A 0
D	10
B	111
C	110

adbc
pop 2 into unique nodes
loop until parent_node.length == dict.keys.length
  combine to form parent_node
  pop 1 into new node
end


First count the amount of times each character appears, and assign this as a "weight" to each character, or node. Add all the nodes to a LIST.

Then, repeat these steps until there is only one node left:

Find the two nodes with the lowest weights.
Create a parent node for these two nodes. Give this parent node a weight of the sum of the two nodes.
Remove the two nodes from the list, and add the parent node.
