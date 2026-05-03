# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Product.destroy_all

Product.create!([
                  { name: 'Tシャツ(白)', description: 'シンプルな白Tシャツ', price_cents: 2_500_00, stock: 10 },
                  { name: 'Tシャツ(黒)', description: 'シンプルな黒Tシャツ', price_cents: 2_500_00, stock: 5 },
                  { name: 'ジーンズ', description: 'デニムパンツ', price_cents: 8_900_00, stock: 3 },
                  { name: 'スニーカー', description: '白スニーカー', price_cents: 12_000_00, stock: 0 },
                  { name: 'キャップ', description: '黒キャップ', price_cents: 3_500_00, stock: 8 }
                ])

puts "Created #{Product.count} products"
