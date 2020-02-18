import "io"

manifest
{
  data = 0,
  left = 1,
  right = 2,
  size = 10000,
  sizeof_node = 3,
  buff = 2
}
  
let new_node(x) be
{
  let ptr = newvec(sizeof_node);
  ptr ! data  := x;
  ptr ! left  := nil;
  ptr ! right := nil;
  resultis ptr;
}



/* adds an element to the tree */
/* root: the root node of the tree, is a pointer to a pointer*/
let add(root, val) be
{
  if root = nil then
  {
    resultis new_node(val);
  }
  test root ! data > val then
  {
    root ! left := add(root ! left,val);
  }
  else
  {
    root ! right := add(root ! right,val);
  }

  resultis root;
}

/*[> removes an element from the tree <]*/
/*let remove(val) be*/
/*{*/

/*}*/


/*[> delete entire tree <]*/
/*let rmTree(root)*/
/*{*/
   
/*}*/

/* print tree */
let printTree(rootPtr) be
{
  if rootPtr = nil then
  {
    return; 
  }
  printTree(rootPtr ! left);
  out("%s\n",rootPtr ! data);
  printTree(rootPtr ! right);


}

let strcpy(dst, src) be
{
  let i = 0;
  while true do
  {
    let c = byte i of src;
    if c = 0 then
    {
      byte i of dst := c;
      break;
    }
    byte i of dst := c;
    i +:= 1
  }
}

/* src is a ptr to the str being copied
   size is a pointer to the size of the 
   string being coped
*/
let resizeStr(src,size) be
{
  let dst; 
  !size *:= 2; 
  dst := newvec(!size);
  for i = 0 to !size - 1 do
  {
    dst ! i := 0;
  }
  strcpy(dst,!src);
  freevec(!src);
  resultis dst;
}

let getInput(x) be
{
   let c, size = buff, str = newvec(size), length = 0;
   byte length of str:= x;
   length +:= 1;
   while true do
   {
     test length < size * 4 - 1 do
     {
       c := inch();
       if c < 'A' \/ c > 'z' then
         break;
       byte length of str:=c;
       length +:= 1;
     }
     else
     {
       str := resizeStr(@str,@size);
     }
   }
   byte length of str := 0;
    resultis str;
}


let start() be
{

  /*  TODO:
   *  Program must:
   *  - accept string from user X
   *  - put them into a binary tree
   *  - print tree in alphabetical order when user types * 
   *  - delete entrie tree, and repat all over
   */

  let uInput, treeRoot = nil, heap = vec(size), i = 0, c;

  /* initialize heap */
  init(heap,size);


  while true do
  {

    c := inch();
    test c = '*' then
    {
      printTree(treeRoot);
      //rmTree(treeRoot);
    }
    else
    {
      uInput := getInput(c);
      treeRoot := add(treeRoot,uInput);
    }
  }

}
