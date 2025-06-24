# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'API V1 Order Items', type: :request do
  path '/api/v1/orders/{order_id}/order_items' do
    get 'List all order items' do
      tags 'Order Items'
      produces 'application/json'

      response '200', 'ok' do
        let!(:order_item) { create(:order_item) }
        let(:order_id) { order_item.order.id }
        run_test!
      end
    end

    post 'Create an order item' do
      tags 'Order Items'
      consumes 'application/json'
      parameter name: :order_item, in: :body, schema: {
        type: :object,
        properties: {
          product_id: { type: :integer },
          quantity: { type: :integer },
          unit_price: { type: :number }
        },
        required: %w[product_id quantity unit_price]
      }

      response '201', 'Order item created' do
        let(:order_id) { create(:order).id }
        let(:order_item) { attributes_for(:order_item) }
        run_test!
      end
    end

    path '/api/v1/order_items/{id}' do
      parameter name: :id, in: :path, type: :string, description: 'Order Item ID'

      get 'Show an order item' do
        tags 'Order Items'
        produces 'application/json'

        response '200', 'ok' do
          let!(:order_item) { create(:order_item) }
          let(:id) { order_item.id }
          run_test!
        end

        response '404', 'Order item not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end

      patch 'Update an order item' do
        tags 'Order Items'
        consumes 'application/json'
        parameter name: :order_item, in: :body, schema: {
          type: :object,
          properties: {
            product_id: { type: :integer },
            quantity: { type: :integer },
            unit_price: { type: :number }
          },
          required: %w[product_id quantity unit_price]
        }

        response '200', 'Order item updated' do
          let!(:existing_order_item) { create(:order_item) }
          let(:id) { existing_order_item.id }
          let(:order_item) { attributes_for(:order_item) }
          run_test!
        end

        response '404', 'Order item not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end

      delete 'Delete an order item' do
        tags 'Order Items'
        produces 'application/json'

        response '200', 'Order item deleted' do
          let!(:order_item) { create(:order_item) }
          let(:id) { order_item.id }
          run_test!
        end

        response '404', 'Order item not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end
  end
end
