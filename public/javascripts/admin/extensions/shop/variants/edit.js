document.observe("dom:loaded", function() {
  shop_variant_edit = new ShopVariantEdit();
  shop_variant_edit.initialize();
  
  Event.addBehavior({
    '#variants .delete:click' : function(e) { shop_variant_edit.variantRemove($(this).up('.variant')) }
  })
});

var ShopVariantEdit = Class.create({
  
  initialize: function() {
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