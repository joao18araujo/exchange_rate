require 'test_helper'

class BrlExchangeRatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brl_exchange_rate = brl_exchange_rates(:one)
  end

  test "should get index" do
    get brl_exchange_rates_url
    assert_response :success
  end

  test "should get new" do
    get new_brl_exchange_rate_url
    assert_response :success
  end

  test "should create brl_exchange_rate" do
    assert_difference('BrlExchangeRate.count') do
      post brl_exchange_rates_url, params: { brl_exchange_rate: { date: @brl_exchange_rate.date, value: @brl_exchange_rate.value } }
    end

    assert_redirected_to brl_exchange_rate_url(BrlExchangeRate.last)
  end

  test "should show brl_exchange_rate" do
    get brl_exchange_rate_url(@brl_exchange_rate)
    assert_response :success
  end

  test "should get edit" do
    get edit_brl_exchange_rate_url(@brl_exchange_rate)
    assert_response :success
  end

  test "should update brl_exchange_rate" do
    patch brl_exchange_rate_url(@brl_exchange_rate), params: { brl_exchange_rate: { date: @brl_exchange_rate.date, value: @brl_exchange_rate.value } }
    assert_redirected_to brl_exchange_rate_url(@brl_exchange_rate)
  end

  test "should destroy brl_exchange_rate" do
    assert_difference('BrlExchangeRate.count', -1) do
      delete brl_exchange_rate_url(@brl_exchange_rate)
    end

    assert_redirected_to brl_exchange_rates_url
  end
end
