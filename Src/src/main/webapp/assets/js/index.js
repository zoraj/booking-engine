var i=0;
		
function deleteRoom(i){
	$('#room'+i).hide();
}

jQuery(document).ready(function () {	
	$("#add-room").click(function () {
		$('#other-room-add').append($("<div class='row' id='room"+i+"'>"
									+ "<div class='col-md-3'>"
									+ "<div class='form-group'><span class='form-label'></span>"
									+ "<select class='form-control'><option>1</option><option>2</option><option>3</option></select>"
									+ "<span class='select-arrow'></span></div></div>"
									+ "<div class='col-md-4'>"
									+ "<div class='form-group'><span class='form-label'></span>"
									+ "<select class='form-control'><option>1 Person</option><option>2 People</option><option>3 People</option></select>"
									+ "<span class='select-arrow'></span></div></div>"
									+ "<div class='col-md-3'>"
									+ "<div class='form-group'><span class='form-label'></span>"
									+ "<select class='form-control'><option>1</option><option>2</option><option>3</option></select>"
									+ "<span class='select-arrow'></span></div></div>"
									+ "<div class='col-md-2'>"
									+ "<div class='form-group'><button class='btn' onclick='deleteRoom("+i+")'>(-)</button></div></div>"
									+ "</div>"));
		i++;
	});	

	$('.form-control').each(function () {
			floatedLabel($(this));
		});

		$('.form-control').on('input', function () {
			floatedLabel($(this));
		});

		function floatedLabel(input) {
			var $field = input.closest('.form-group');
			if (input.val()) {
				$field.addClass('input-not-empty');
			} else {
				$field.removeClass('input-not-empty');
			}
		}
	
});


   
