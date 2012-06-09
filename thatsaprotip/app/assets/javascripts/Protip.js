(function($) {
  function Like(root, id) {
    this._root = $(root);
    this._id = id;
  }

  Like.prototype = {
    click: function() {
      console.log('hello');
      var liked_status = this._getLikedStatus();
      var count = this._getCount();
      // optimistically update UI
      this._setLikedStatus(!liked_status);
      this._setCount(liked_status + (liked_status ? -1 : 1));

      $.ajax({
        url: '/protips/' + this._id + '/like',
        type: 'POST',
        dataType: 'json',
        success: function(data) {
          // update the UI with server-backed values
          this._setLikedStatus(data.liked);
          this._setCount(data.count);
        }.bind(this),
        error: function(data) {
          // revert
          this._setLikedStatus(liked_status);
          this._setCount(count);
        }.bind(this)
      });
    },

    _getCount: function() {
      return parseInt($('.count', this._root).html(), 10);
    },

    _setCount: function(count) {
      $('.count', this._root).html(count);
    },

    _getLikedStatus: function() {
      return this._root.hasClass('liked');
    },

    _setLikedStatus: function(liked) {
      this._root.toggleClass(
        'liked',
        liked
      );
    }
  };

  $.fn.Protip = function() {
    var root = this;
    var id = parseInt(root.attr('id').match(/protip_(\d+)/)[1], 10);
    // lazily instantiate a like object
    var like;

    root.click(function(event) {
      var like_root = $(event.target).closest('.like');
      if (like_root[0]) {
        like || (like = new Like(like_root, id));
        like.click();
      }
    });
  }
})(jQuery);
