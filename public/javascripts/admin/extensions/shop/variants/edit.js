document.observe("dom:loaded", function() {
  shop_variant_edit = new ShopVariantEdit();
  shop_variant_edit.initialize();
  
  Event.addBehavior({
    '#variants .delete:click' : function(e) { shop_variant_edit.variantRemove($(this).up('.variant')) }
  })
});

var ShopVariantEdit = Class.create({
  
  initialize: function() {
    this.variantsSort();
  },

  variantsSort: function(element) {
    var route = shop.getRoute('sort_admin_shop_product_variants_path');

    Sortable.create('variants', {
      constraint: false, 
      overlap: 'horizontal',
      containment: ['variants'],
      onUpdate: function(element) {
        new Ajax.Request(route, {
          method: 'put',
          parameters: {
            'product_id': $('shop_product_id').value,
            'variants':   Sortable.serialize('variants')
          }
        });
      }.bind(this)
    })
  },
  
  variantRemove: function(element) {
    var variant_id  = element.readAttribute('data-variant_id');
    var route       = shop.getRoute('admin_shop_product_variant_path', 'js', variant_id);
    
    if(confirm('Are you Sure?')) {
      showStatus('Removing Variant...');
      element.hide();
      
      new Ajax.Request(route, { 
        method: 'delete',
        onSuccess: function(data) {
          element.remove();
        }.bind(element),
        onFailure: function(data) {
          element.show();
        }.bind(element),
        onComplete: function() {
          hideStatus();        
        }
      });
    }
  }
  
});
