class DimCustomer < WarehouseRecord
    include RailsAdminCharts

    def self.graph_data since=30.days.ago 
    data = []


    DimCustomer.all.each do |key|
    data.push({
        name: key.ContactFullname,
        pointInterval: point_interval = 1.day * 1000,
        pointStart: start_point = since.to_i * 1000,
        data: [key.NbElevator.to_i]
    })
    end

    data
    end

    def self.chart_type
        "column"
    end
end
