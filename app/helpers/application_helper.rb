# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def render_status(status)
    "<span class='status-update' style='color: #{status.color}'>#{status.status}</span>"
  end

  def panel(options={}, &block)
    concat(%{
    <div class="panel #{options[:class]}">
      <div class="panel_top"><div class="panel_right">
      <div class="panel_bottom"><div class="panel_left">
      <div class="panel_corner02"><div class="panel_corner04">
      <div class="panel_corner03"><div class="panel_corner01">

          #{capture(&block)}

      </div></div></div></div></div></div></div></div>
    </div>
    }, block.binding)
  end
end
