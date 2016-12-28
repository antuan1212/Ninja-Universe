proc/Arctan(x,y)
  // (Courtesy of Lummox JR)
  // corresponds to standard x=cos, y=sin mapping
  // tangent is y/x
  if(!x && !y) return 0    // the only special case
  var/a=arccos(x/sqrt(x*x+y*y))
  return (y>=0)?(a):(-a)



