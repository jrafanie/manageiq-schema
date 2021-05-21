class UpdateProductFeaturesWhereIdentifierWasRenamedFromJansaToLasker < ActiveRecord::Migration[6.0]
  IDENTIFIERS_BEFORE_AND_AFTER = %w(
    control_explorer       control
    policy_profile         miq_policy_set
    policy_profile_view    miq_policy_set_view
    policy_profile_admin   miq_policy_set_admin
    profile_new            miq_policy_set_new
    profile_delete         miq_policy_set_delete
    profile_edit           miq_policy_set_edit
    policy                 miq_policy
    policy_view            miq_policy_view
    policy_admin           miq_policy_admin
    policy_new             miq_policy_new
    policy_copy            miq_policy_copy
    policy_edit            miq_policy_edit
    policy_edit_conditions miq_policy_conditions_assignment
    policy_edit_events     miq_policy_events_assignment
    policy_delete          miq_policy_delete
    event                  miq_event_definition
    action                 miq_action
    action_admin           miq_action_admin
    action_show_list       miq_action_show_list
    action_show            miq_action_show
    action_new             miq_action_new
    action_edit            miq_action_edit
    action_delete          miq_action_delete
    alert_profile          miq_alert_set
    alert_profile_admin    miq_alert_set_admin
    alert_profile_new      miq_alert_set_new
    alert_profile_edit     miq_alert_set_edit
    alert_profile_assign   miq_alert_set_assign
    alert_profile_delete   miq_alert_set_delete
    alert                  miq_alert
    alert_admin            miq_alert_admin
    alert_new              miq_alert_new
    alert_copy             miq_alert_copy
    alert_edit             miq_alert_edit
    alert_delete           miq_alert_delete
  )

  class MiqProductFeature < ActiveRecord::Base; end
  class MiqRolesFeature < ActiveRecord::Base; end

  def up
    say_with_time "Updating renamed product feature identifiers" do
      IDENTIFIERS_BEFORE_AND_AFTER.each_slice(2) do |identifier_before, identifier_after|
        MiqProductFeature.where(:identifier => identifier_before).update_all(:identifier => identifier_after)
      end
    end
  end

  def down
    say_with_time "Reverting renamed product feature identifiers" do
      IDENTIFIERS_BEFORE_AND_AFTER.each_slice(2) do |identifier_before, identifier_after|
        MiqProductFeature.where(:identifier => identifier_after).update_all(:identifier => identifier_before)
      end
    end
  end
end
