require 'spec_helper'

RSpec.describe Doing do
  describe '#update_counts' do
    let(:activity) { create :activity }
    let(:this_weeks_doings) {
      create_list :this_week_doing, 3,
      :activity => activity,
      :created_at => Time.now - 1.days
    }
    let(:past_weeks_doings) {
      create_list :previous_week_doing, 3,
      :activity => activity,
      :created_at => Time.now - 10.days
    }

    before do
      Timecop.freeze(Time.local(2015, 5, 21))
      expect(this_weeks_doings.count).to eq 3
      expect(past_weeks_doings.count).to eq 3
    end

    after do
      Timecop.return
    end

    it "updates its Activity's weekly, monthly, done_last counts" do
      expect(activity.weekly).to eq 3
      expect(activity.monthly).to eq 6

      doing = Doing.create(activity: activity)

      expect(activity.done_last_at).to eq(doing.created_at)
      expect(activity.weekly).to eq 4
      expect(activity.monthly).to eq 7
    end
  end
end
