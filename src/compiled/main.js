// Generated by CoffeeScript 1.3.1
(function() {

  $(function() {
    var Black, design, height, key, keyCenterPosX, keyType, length, pos, scene, width, _i, _len, _ref, _ref1, _results;
    scene = new Scene('#container');
    scene.animate();
    design = new PianoKeyboardDesign;
    width = design.whiteKeyWidth;
    height = design.whiteKeyHeight;
    length = design.whiteKeyLength;
    Black = PianoKeyboardDesign.KeyType.Black;
    _ref = design.keyInfo;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      _ref1 = _ref[_i], keyType = _ref1.keyType, keyCenterPosX = _ref1.keyCenterPosX;
      if (keyType !== Black) {
        pos = new THREE.Vector3(keyCenterPosX, 0, 0);
        key = new PianoKey({
          width: width,
          height: height,
          length: length,
          color: 0xffffff,
          position: pos,
          dip: 0
        });
        _results.push(scene.add(key.mesh));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  });

}).call(this);