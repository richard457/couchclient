//Copyright (C) 2013 Potix Corporation. All Rights Reserved.
//History: Thu, Mar 07, 2013  02:35:43 PM
// Author: hernichen

part of couchclient;

class DeleteDesignDocOP extends DeleteHttpOP {
  final Completer<bool> _cmpl; //completer to complete the future of this operation

  Future<bool> get future
  => _cmpl.future;

  final String designDocName;

  DeleteDesignDocOP(String bucketName, this.designDocName, [int msecs])
      : _cmpl = new Completer() {

    _cmd = Uri.parse('/$bucketName/_design/$designDocName');
  }

  void processResponse(HttpResult result) {
    String base = UTF8.decode(result.contents);
    _logger.finest("DeleteDesignDocOP:base->[$base]");
    if (!base.isEmpty) {
      Map jo = JSON.decode(base);
      bool ok = jo['ok'];
      _cmpl.complete(ok != null && ok);
    } else
      _cmpl.complete(false);
  }
}


