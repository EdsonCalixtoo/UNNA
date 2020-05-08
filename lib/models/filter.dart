enum OrderBy {DATE, NDATE}

class Filter {

  Filter({
    this.search,
    this.orderBy = OrderBy.DATE,
  });

 String search;

 OrderBy orderBy;


}