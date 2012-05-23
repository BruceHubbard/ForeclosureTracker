$ -> 
	$.ajax(
		url: "auction"
		success: (data) -> 
			html = HandlebarsTemplates['listing']({auctions: data})
			$('#listing').html(html)
	)