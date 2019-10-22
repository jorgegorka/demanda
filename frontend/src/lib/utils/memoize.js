/* This function has been copied from:
    http://inlehmansterms.net/2015/03/01/javascript-memoization/
*/

function memoize(func) {
  var cache = {};
  return function() {
    var key = JSON.stringify(arguments);
    if (cache[key]) {
      return cache[key];
    } else {
      var val = func.apply(this, arguments);
      cache[key] = val;
      return val;
    }
  };
}

export { memoize };
