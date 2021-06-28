# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_03_090437) do

  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deadlines", force: :cascade do |t|
    t.integer "nombre_de_jour"
    t.decimal "tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "demandes", force: :cascade do |t|
    t.integer "utilisateur_id"
    t.integer "nombre_de_jour"
    t.decimal "taux"
    t.datetime "date_accepted"
    t.datetime "date_disbursed"
    t.datetime "date_repaid"
    t.datetime "repayment_date"
    t.integer "penalty_amount"
    t.integer "total_amount_paid"
    t.string "lender_phone"
    t.boolean "is_anonymous"
    t.integer "amount_borrowed"
    t.integer "amount_to_repay"
    t.integer "category_id"
    t.string "phone"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "otps", force: :cascade do |t|
    t.string "num_phone"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "demande_id"
    t.datetime "date_sent"
    t.datetime "date_received"
    t.string "sender_phone"
    t.string "receiver_phone"
    t.integer "amount"
    t.string "tx_reference"
    t.string "payment_reference"
    t.boolean "is_envoi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "taux_entree"
    t.decimal "taux_sortie"
    t.decimal "taux_preteur"
  end



  create_table "utilisateurs", force: :cascade do |t|
    t.string "nom"
    t.string "prenoms"
    t.integer "age"
    t.string "sexe"
    t.string "quartier"
    t.text "id_document_url"
    t.text "photo_url"
    t.string "password_digest"
    t.string "phone"
    t.string "pseudo"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
