# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Dmm::Price do
  context 'with valid response' do
    before(:all) do
      @items = sample_response.items
    end

    subject { @items.first.prices }

    its(:min_price)      { should eq 500 }
    its(:deliveries)     { should eq [{:type=>"stream", :price=>"500"}, {:type=>"download", :price=>"980"}, {:type=>"hd", :price=>"1480"}, {:type=>"androiddl", :price=>"980"}] }
    its(:delivery_types) { should eq ['stream', 'download', 'hd', 'androiddl'] }

    describe 'method_missing' do
      its(:price_stream)    { should eq 500 }
      its(:price_download)  { should eq 980 }
      its(:price_hd)        { should eq 1480 }
      its(:price_androiddl) { should eq 980 }
      its(:price_toaster)   { should be_nil }
    end

    describe 'respond_to?' do
      %w(price_stream price_download price_hd price_androiddl).each do |method|
        it "should be true with argument #{method}" do
          subject.respond_to?(method.to_sym).should be_true
        end
      end

      it 'should be true with non-existent price type' do
        subject.respond_to?(:price_toaster).should be_true
      end
    end
  end
end