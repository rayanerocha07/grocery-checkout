# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'API V1 Orders', type: :request do
  path '/api/v1/orders' do
    get 'List all orders' do
      tags 'Orders'
      produces 'application/json'

      response '200', 'ok' do
        let!(:order) { create(:order) }
        run_test!
      end
    end

    post 'Create an order' do
      tags 'Orders'
      consumes 'application/json'
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          order_items_attributes: {
            type: :array,
            items: {
              type: :object,
              properties: {
                product_id: { type: :integer },
                quantity: { type: :integer },
                unit_price: { type: :integer }
              },
              required: %w[product_id quantity]
            }
          }
        },
        required: [ 'order_items_attributes' ]
      }

      response '201', 'Order created' do
        let(:order) do
          {
            order_items_attributes: [
              {
                product_id: create(:product).id,
                quantity: 2
              }
            ]
          }
        end
        run_test!
      end

      response '422', 'Invalid request' do
        let(:order) { { order_items_attributes: [] } }
        run_test!
      end
    end
  end

  path '/api/v1/orders/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'Order ID'

    get 'Show an order by ID' do
      tags 'Orders'
      produces 'application/json'

      response '200', 'ok' do
        let!(:order) { create(:order) }
        let(:id) { order.id }
        run_test!
      end

      response '404', 'Order not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Update an order' do
      tags 'Orders'
      consumes 'application/json'
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: { status: { type: :string } },
        required: [ 'status' ]
      }

      response '200', 'Order updated' do
        let!(:existing_order) { create(:order) }
        let(:id) { existing_order.id }
        let(:order) { { status: 'completed' } }
        run_test!
      end

      response '422', 'Invalid request' do
        let!(:existing_order) { create(:order) }
        let(:id) { existing_order.id }
        let(:order) { { status: nil } }
        run_test!
      end
    end

    delete 'Delete an order' do
      tags 'Orders'

      response '204', 'Order deleted' do
        let!(:order) { create(:order) }
        let(:id) { order.id }
        run_test!
      end

      response '404', 'Order not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
