// Should we be allowing partial selections in the first place?
// Remove tags option to only allow full word selections
$(document).on('DOMContentLoaded cocoon:after-insert', function(e, inserted) {
  $(".entity-fields-multiple").select2({
    placeholder: "Entity Text",
    tags: true,
    tokenSeparators: [' '],
    data: formatted_data()
  })
})

$('textarea#sentence_text').bind('input', function() {
  $(".entity-fields-multiple").each(function(i, obj) {
    // Cache values before removing all options
    let current_value = $(obj).val()
    // Clear all values to prevent h he hel hell hello
    $(obj).val(null).empty().select2('destroy')
    // Add values
    $(obj).select2({
      placeholder: "Entity Text",
      tags: true,
      tokenSeparators: [' '],
      data: formatted_data(current_value)
    })
    // Add cached values
    $(obj).val(current_value).trigger("change")
  })
});

function formatted_data(current=[]) {
  // Add current to formatted data to avoid removal in case it was a custom element
  let data = String($('textarea#sentence_text').val()).split(' ')
  data = data.concat(current)
  data = data.filter((c, index) => {
    return data.indexOf(c) === index;
  });
  let formatted_data = $.map(data, function (obj) {
    return {id: obj, text: obj};
  });  
  return formatted_data
}

// Prevent select2 auto sorting
$(".entity-fields-multiple").on("select2:select", function (e) {
  let id = e.params.data.id;
  let option = $(e.target).children('[value='+id+']');
  option.detach();
  $(e.target).append(option).change();
});