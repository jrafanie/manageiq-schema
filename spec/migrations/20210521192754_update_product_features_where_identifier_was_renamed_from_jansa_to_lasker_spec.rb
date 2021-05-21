require_migration

describe UpdateProductFeaturesWhereIdentifierWasRenamedFromJansaToLasker do
  let(:user_role_id) { anonymous_class_with_id_regions.id_in_region(1, anonymous_class_with_id_regions.my_region_number) }
  let(:feature_stub) { migration_stub :MiqProductFeature }
  let(:roles_feature_stub) { migration_stub :MiqRolesFeature }
  let(:user_stub) { migration_stub :User }

  migration_context :up do
    describe 'product features update' do
      it "renamed features aren't removed from user roles" do
        features = {}
        UpdateProductFeaturesWhereIdentifierWasRenamedFromJansaToLasker::IDENTIFIERS_BEFORE_AND_AFTER.each_slice(2) do |before, _|
          feature = feature_stub.create!(:identifier => before)
          features[before] = feature
          roles_feature_stub.create!(:miq_product_feature_id => feature.id, :miq_user_role_id => user_role_id)
        end
        expect(roles_feature_stub.where(:miq_user_role_id => user_role_id).count).to eq(features.keys.length)

        migrate

        UpdateProductFeaturesWhereIdentifierWasRenamedFromJansaToLasker::IDENTIFIERS_BEFORE_AND_AFTER.each_slice(2) do |before, after|
          after_feature = features[before].reload
          expect(after_feature.identifier).to eq(after)
          expect(roles_feature_stub.where(:miq_user_role_id => user_role_id, :miq_product_feature_id => after_feature.id).count).to eq(1)
        end
        expect(roles_feature_stub.where(:miq_user_role_id => user_role_id).count).to eq(features.keys.length)
      end
    end
  end

  migration_context :down do
    describe 'product features update' do
      it "renamed features aren't removed from user roles" do
        features = {}
        UpdateProductFeaturesWhereIdentifierWasRenamedFromJansaToLasker::IDENTIFIERS_BEFORE_AND_AFTER.each_slice(2) do |_, after|
          feature = feature_stub.create!(:identifier => after)
          features[after] = feature
          roles_feature_stub.create!(:miq_product_feature_id => feature.id, :miq_user_role_id => user_role_id)
        end
        expect(roles_feature_stub.where(:miq_user_role_id => user_role_id).count).to eq(features.keys.length)

        migrate

        UpdateProductFeaturesWhereIdentifierWasRenamedFromJansaToLasker::IDENTIFIERS_BEFORE_AND_AFTER.each_slice(2) do |before, after|
          before_feature = features[after].reload
          expect(before_feature.identifier).to eq(before)
          expect(roles_feature_stub.where(:miq_user_role_id => user_role_id, :miq_product_feature_id => before_feature.id).count).to eq(1)
        end
        expect(roles_feature_stub.where(:miq_user_role_id => user_role_id).count).to eq(features.keys.length)
      end
    end
  end
end
