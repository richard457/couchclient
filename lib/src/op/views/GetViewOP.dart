//Copyright (C) 2013 Potix Corporation. All Rights Reserved.
//History: Thu, Mar 08, 2013  10:36:35 AM
// Author: hernichen

part of couchclient;

class GetViewOP extends GetHttpOP {
  final Completer<View> _cmpl; //completer to complete the future of this operation

  Future<View> get future
  => _cmpl.future;

  final String bucketName;
  final String designDocName;
  final String viewName;

  GetViewOP(this.bucketName, this.designDocName, this.viewName, [int msecs])
      : _cmpl = new Completer() {
    _cmd = Uri.parse('/$bucketName/_design/$designDocName');
  }

  void processResponse(HttpResult result) {
    String base = UTF8.decode(result.contents);
    //_logger.finest("GetViewOP:base->[$base]");
    Map jo = JSON.decode(base);
    Map<String, Map> viewsjo = jo['views'];
    if (viewsjo != null) {
      for(String name in viewsjo.keys) {
        if (viewName == name) {
          Map<String, String> mapjo = viewsjo[name];
          View view = new View(bucketName, designDocName, viewName,
                        mapjo.containsKey('map'), mapjo.containsKey('reduce'));
          _cmpl.complete(view);
          return;
        }
      }
    }
    _cmpl.complete(null);
  }
}


