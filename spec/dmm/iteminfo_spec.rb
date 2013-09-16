# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Dmm::Iteminfo do
  context 'with valid response' do
    before(:all) do
      @items = sample_response.items
    end

    context 'with first item' do
      subject { @items.first.iteminfo }

      its(:keyword) { should eq ['エステ', 'ナンパ', '人妻', '痴女', '巨乳', '独占配信', 'ハイビジョン'] }
      its(:maker)   { should eq '変態紳士倶楽部' }
      its(:label)   { should eq '変態紳士倶楽部' }

      describe 'respond_to?' do
        %w(series maker label keyword actress director author).each do |method|
          it "should be ture with argument #{method.to_sym}" do
            subject.respond_to?(method.to_sym).should be_true
          end
        end
      end
    end
  end
end