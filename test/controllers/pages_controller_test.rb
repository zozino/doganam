require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get accueil" do
    get pages_createcompte_url
    assert_response :success
  end

  test "should get createcompte" do
    get pages_createcompte_url
    assert_response :success
  end

  test "should get corrigercompte" do
    get pages_corrigercompte_url
    assert_response :success
  end

  test "should get connexion" do
    get pages_connexion_url
    assert_response :success
  end

  test "should get demandepret" do
    get pages_demandepret_url
    assert_response :success
  end

  test "should get acceptpret" do
    get pages_acceptpret_url
    assert_response :success
  end

  test "should get evolutiondemande" do
    get pages_evolutiondemande_url
    assert_response :success
  end

  test "should get rembourspret" do
    get pages_rembourspret_url
    assert_response :success
  end

  test "should get infodemandeur" do
    get pages_infodemandeur_url
    assert_response :success
  end

  test "should get deconnecter" do
    get pages_deconnecter_url
    assert_response :success
  end

  test "should get createcomptevalider" do
    get pages_createcomptevalider_url
    assert_response :success
  end

  test "should get corrigercomptevalider" do
    get pages_corrigercomptevalider_url
    assert_response :success
  end

  test "should get connexionvalider" do
    get pages_connexionvalider_url
    assert_response :success
  end

  test "should get demandepretvalider" do
    get pages_demandepretvalider_url
    assert_response :success
  end

end
