# frozen_string_literal: true

# ReportsController
class ReportsController < ApplicationController
  before_action :report_date_params, except: %i[index]

  def index
    redirect_to action: 'overview'
  end

  # G2
  def overview
    # Primary date range query
    @search = Report::Overview.new(report_params.to_h)

    @comparison = Report::Overview.new(report_params.to_h, compare: true)
    logger.debug("Compare: #{@comparison.date_start} | #{@comparison.date_end}")

    logger.debug("Report Params: #{report_params.to_h.inspect}")
    logger.debug("Search: #{@search.date_start} | #{@search.date_end}")
  end

  private

  def report_date_params
    # Initial query
    params[:created_at] ||= {}
    @date_range = params[:created_at][:range] ||= 'last4weeks'

    @date_start = params[:created_at][:start] ||= (28.days.ago).strftime(I18n.t('date.formats.default'))

    @date_end = params[:created_at][:end] ||= (Time.zone.now).strftime(I18n.t('date.formats.default'))

    # Comparison query
    return unless params[:compare] == 'true'

    @date_compare = params[:created_at][:compare] ||= {}

    @date_compare_start = params[:created_at][:compare][:start] ||= (Chronic.parse(@date_start) - 28.days).strftime(I18n.t('date.formats.default'))

    @date_compare_end = params[:created_at][:compare][:end] ||= (Chronic.parse(@date_end) - 1.day).strftime(I18n.t('date.formats.default'))
  end

  def report_params
    params.permit(
      :search_field,
      :compare,
      :compare_toggle,
      :q,
      :sort,
      :page,
      f: {
        gbl_resourceClass_sm: [],
        b1g_publication_state_s: [],
        schema_provider_s: [],
        b1g_dct_accrualMethod_s: [],
        dct_accessRights_s: []
      },
      created_at: [
        :range,
        :start,
        :start_iso,
        :end,
        :end_iso,
        { compare: %i[
          range
          start
          start_iso
          end
          end_iso
        ] }
      ],
      report: %i[
        start_date
        end_date
      ]
    )
  end
end
