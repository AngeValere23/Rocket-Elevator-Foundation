class FactQuote < WarehouseRecord
    include RailsAdminCharts

    def self.graph_data since=30.days.ago 
    data = []


    FactQuote.all.group_by {|u| u.CreationDate.beginning_of_month }.each do |key , value|
        data.push({
            name: key.strftime("%Y-%m"),
            pointInterval: point_interval = 1.day * 1000,
            pointStart: start_point = since.to_i * 1000,
            data: [value.size]
        })
        end
    

    data
    end

    def self.chart_type
        "column"
    end
end
