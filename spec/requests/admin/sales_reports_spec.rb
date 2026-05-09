require 'rails_helper'

RSpec.describe "Admin::SalesReports", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/admin/sales_reports/show"
      expect(response).to have_http_status(:success)
    end
  end

end
