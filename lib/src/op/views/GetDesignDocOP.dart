//Copyright (C) 2013 Potix Corporation. All Rights Reserved.
//History: Thu, Mar 07, 2013  02:35:43 PM
// Author: hernichen

part of couchclient;

class GetDesignDocOP extends GetHttpOP {
  final Completer<DesignDoc> _cmpl; //completer to complete the future of this operation

  Future<DesignDoc> get future
  => _cmpl.future;

  final String designDocName;

  GetDesignDocOP(String bucketName, this.designDocName, [int msecs])
      : _cmpl = new Completer() {

    _cmd = Uri.parse('/$bucketName/_design/$designDocName');
  }

  void processResponse(HttpResult result) {
    String base = UTF8.decode(result.contents);
    Map jo = JSON.decode(base);
    if (jo.containsKey('error')) {
      _cmpl.complete(null);
    } else {
      _cmpl.complete(_newDesignDoc(designDocName, jo));
    }
  }
}

DesignDoc _newDesignDoc(String ddocName, Map jo) {
  String language = jo['language'];
  Map<String, Map> viewsjo = jo['views'];
  List<ViewDesign> views = new List();
  if (viewsjo != null) {
    for(String viewname in viewsjo.keys) {
      Map mapjo = viewsjo[viewname];
      views.add(new ViewDesign(viewname, mapjo['map'], mapjo['reduce']));
    }
  }
  Map<String, Map> spatialViewsjo = jo['spatial'];
  List<SpatialViewDesign> spatialViews = new List();
  if (spatialViewsjo != null) {
    for(String viewname in spatialViewsjo.keys) {
      Map mapjo = spatialViewsjo[viewname];
      spatialViews.add(new SpatialViewDesign(viewname, mapjo['map']));
    }
  }
  return new DesignDoc(ddocName, language:language, views:views, spatialViews:spatialViews);
}



