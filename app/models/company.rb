class Company < ActiveRecord::Base
    has_many :freebies
    has_many :devs, through: :freebies

    def freebies
        company_freebies = Freebie.all.select{|freebie| self.id==freebie.company_id}
    end
    def devs
        company_devs = []
        self.freebies.each do |freebie|
            company_devs << Dev.find(freebie.dev_id)
        end
        company_devs
    end
    def give_freebie(dev, item_name, value)
        Freebie.create(
            item_name: item_name,
            value: value,
            company_id: self.id,
            dev_id: dev.id
        )
    end
    def self.oldest_company
        Company.all.sort_by(&:founding_year)[0]
    end
end
