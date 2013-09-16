# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Dmm::Error do
  context 'with response status code is 400' do
    before do
      @client = response_with_error([400, "Bad Request"])
    end

    subject { @client }

    it 'should raise Dmm::InternalServerError' do
      lambda { subject.item_list(:keyword => '巨乳') }.should raise_error Dmm::BadRequest
    end
  end

  context 'with response status code is 401' do
    before do
      @client = response_with_error([401, "Unauthorized"])
    end

    subject { @client }

    it 'should raise Dmm::InternalServerError' do
      lambda { subject.item_list(:keyword => '巨乳') }.should raise_error Dmm::Unauthorized
    end
  end

  context 'with response status code is 403' do
    before do
      @client = response_with_error([403, "Frobidden"])
    end

    subject { @client }

    it 'should raise Dmm::InternalServerError' do
      lambda { subject.item_list(:keyword => '巨乳') }.should raise_error Dmm::Forbidden
    end
  end

  context 'with response status code is 404' do
    before do
      @client = response_with_error([404, "Not Found"])
    end

    subject { @client }

    it 'should raise Dmm::InternalServerError' do
      lambda { subject.item_list(:keyword => '巨乳') }.should raise_error Dmm::NotFound
    end
  end

  context 'with response status code is 406' do
    before do
      @client = response_with_error([406, "Not Acceptable"])
    end

    subject { @client }

    it 'should raise Dmm::InternalServerError' do
      lambda { subject.item_list(:keyword => '巨乳') }.should raise_error Dmm::NotAcceptable
    end
  end

  context 'with response status code is 422' do
    before do
      @client = response_with_error([422, "Unprocessable Entity"])
    end

    subject { @client }

    it 'should raise Dmm::InternalServerError' do
      lambda { subject.item_list(:keyword => '巨乳') }.should raise_error Dmm::UnprocessableEntity
    end
  end

  context 'with response status code is 500' do
    before do
      @client = response_with_error([500, "Internal Server Error"])
    end

    subject { @client }

    it 'should raise Dmm::InternalServerError' do
      lambda { subject.item_list(:keyword => '巨乳') }.should raise_error Dmm::InternalServerError
    end
  end

  context 'with response status code is 503' do
    before do
      @client = response_with_error([503, "Service Unavailable"])
    end

    subject { @client }

    it 'should raise Dmm::InternalServerError' do
      lambda { subject.item_list(:keyword => '巨乳') }.should raise_error Dmm::ServiceUnavailable
    end
  end
end