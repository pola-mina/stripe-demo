module ApiHelper
  extend ActiveSupport::Concern
  
  def listing_records(records, params)
    @total_count = records.length

    params[:sort_by] ||= 'id'
    params[:sort_dir] ||= 'asc'
    params[:page] ||= 1
    params[:limit] ||= @total_count

    records.order(params[:sort_by].to_sym => params[:sort_dir].to_sym)
          .paginate(page: params[:page], per_page: params[:limit])
    return records unless params[:filters]

    JSON.parse(params[:filters]).each do |key, value|
      records = records.where(key.to_sym => value) if records.first.class.method_defined? key.to_sym
    end

    records
  end

  def set_fields
    params[:fields] = params[:fields].present? ? params[:fields]&.map(&:to_sym) : []
  end
end
