(function($) {
  function Favorite(root, id) {
    this._root = $(root);
    this._id = id;
  }

  Favorite.prototype = {
    click: function() {
      var favorited_status = this._getFavoritedStatus();
      var new_count = this._getCount() + (favorited_status ? -1 : 1);
      // optimistically update UI
      this._setFavoritedStatus(!favorited_status);
      this._setCount(new_count);

      $.ajax({
        url: '/protips/' + this._id + '/favorite',
        type: 'POST',
        dataType: 'json',
        success: function(data) {
          this._setFavoritedStatus(data.favorited);
          this._setCount(data.count);
        }.bind(this)
      });
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
    var id = parseInt(root.attr('id').match(/protip_(\d+)/)[1], 10);
    // lazily instantiate a favorite object
    var favorite;

    root.click(function(event) {
      var favorite_root = $(event.target).closest('.favorite');
      if (favorite_root[0]) {
        favorite || (favorite = new Favorite(favorite_root, id));
        favorite.click();
      }
    });
  }
})(jQuery);
