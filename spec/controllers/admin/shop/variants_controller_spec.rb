require 'spec/spec_helper'

describe Admin::Shop::VariantsController do
  
  dataset :users, :shop_variants
  
  before(:each) do
    login_as  :admin
  end
  
  describe '#new' do
    context 'instance variables' do
      it 'should be assigned' do
        get :new
        
        assigns(:inputs).should   === ['name','options']
        assigns(:meta).should     === []
        assigns(:buttons).should  === []
        assigns(:parts).should    === []
        assigns(:popups).should   === []
      end
    end
  end
  
  describe '#edit' do
    context 'instance variables' do
      it 'should be assigned' do
        get :edit, :id => shop_variants(:bread_states).id
        
        assigns(:inputs).should   === ['name','options']
        assigns(:meta).should     === []
        assigns(:buttons).should  === []
        assigns(:parts).should    === []
        assigns(:popups).should   === []
      end
    end
  end
  
  describe '#create' do
    context 'instance variables' do
      it 'should be assigned' do
        post :create, :shop_variant => {}
        
        assigns(:inputs).should   === ['name','options']
        assigns(:meta).should     === []
        assigns(:buttons).should  === []
        assigns(:parts).should    === []
        assigns(:popups).should   === []
      end
    end
  end
  
  describe '#update' do
    context 'instance variables' do
      it 'should be assigned' do
        put :update, :id => shop_variants(:bread_states).id, :shop_variant => {}
        
        assigns(:inputs).should   === ['name','options']
        assigns(:meta).should     === []
        assigns(:buttons).should  === []
        assigns(:parts).should    === []
        assigns(:popups).should   === []
      end
    end
  end
  
end