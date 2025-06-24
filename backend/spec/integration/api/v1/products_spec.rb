# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'API V1 Products', type: :request do
  path '/api/v1/products' do
    get 'List all products' do
      tags 'Products'
      produces 'application/json'

      response '200', 'ok' do
        let!(:product) { create(:product) }
        run_test!
      end
    end

    post 'Create a product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number },
          description: { type: :string }
        },
        required: %w[name price description]
      }

      response '201', 'Product created' do
        let(:product) { attributes_for(:product) }
        run_test!
      end
    end

    path '/api/v1/products/{id}' do
      parameter name: :id, in: :path, type: :string, description: 'Product ID'

      get 'Show a product' do
        tags 'Products'
        produces 'application/json'

        response '200', 'ok' do
          let!(:product) { create(:product) }
          let(:id) { product.id }
          run_test!
        end

        response '404', 'Product not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end

      patch 'Update a product' do
        tags 'Products'
        consumes 'application/json'
        parameter name: :product, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            price: { type: :number },
            description: { type: :string }
          },
          required: %w[name price description]
        }

        response '200', 'Product updated' do
          let!(:existing_product) { create(:product) }
          let(:id) { existing_product.id }
          let(:product) { attributes_for(:product) }
          run_test!
        end

        response '404', 'Product not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end

      delete 'Delete a product' do
        tags 'Products'
        produces 'application/json'

        response '200', 'Product deleted' do
          let!(:product) { create(:product) }
          let(:id) { product.id }
          run_test!
        end

        response '404', 'Product not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end
  end
end
