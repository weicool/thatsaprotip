(function($) {
  function Favorite(root) {
    this._root = $(root);
  }

  Favorite.prototype = {
    click: function() {
      var favorited_status = this._getFavoritedStatus();
      var new_count = this._getCount() + (favorited_status ? -1 : 1);
      // optimistically update UI
      this._setFavoritedStatus(!favorited_status);
      this._setCount(new_count);
    },

    _getCount: function() {
      return parseInt($('.count', this._root).html(), 10);
    },

    _setCount: function(count) {
      $('.count', this._root).html(count);
    },

    _getFavoritedStatus: function() {
      return this._root.hasClass('favorited');
    },

    _setFavoritedStatus: function(favorited) {
      this._root.toggleClass(
        'favorited',
        favorited
      );
    }
  };

  $.fn.Protip = function() {
    var root = this;
    // lazily instantiate a favorite object
    var favorite;

    root.click(function(event) {
      var favorite_root = $(event.target).closest('.favorite');
      if (favorite_root) {
        favorite || (favorite = new Favorite(favorite_root));
        favorite.click();
      }
    });
  }
})(jQuery);
