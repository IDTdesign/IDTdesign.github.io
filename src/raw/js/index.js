// external js: isotope.pkgd.js

// init Isotope
var $grid = $('.isotope-grid').isotope({
    percentPosition: false,
    itemSelector: '.isotope-grid-item',
    stagger: 30,
    masonry: {
        columnWidth: '.isotope-grid-sizer'
    }
});

// store filter for each group
var filters = {};

$('.isotope-filters-trigger').on( 'click', '.filter-button', function() {
    $('.isotope-filters').toggleClass( 'isotope-filters-popup');
})

$('.isotope-filters-popup-close').on( 'click', function() {
    $('.isotope-filters').toggleClass( 'isotope-filters-popup');
})

$('.isotope-filters').on( 'click', '.filter-button', function() {
    var $this = $(this);
    // get group key
    var $buttonGroup = $this.parents('.filter-button-group');
    var filterGroup = $buttonGroup.attr('data-filter-group');
    // set filter for group
    filters[ filterGroup ] = $this.attr('data-filter');
    // combine filters
    var filterValue = concatValues( filters );
    // set filter for Isotope
    $grid.isotope({ filter: filterValue });
    //console.log(filterValue);
});

// change is-checked class on buttons
$('.filter-button-group').each( function( i, buttonGroup ) {
    var $buttonGroup = $( buttonGroup );
    $buttonGroup.on( 'click', '.filter-button', function() {
        $buttonGroup.find('.is-checked').removeClass('is-checked');
        $( this ).addClass('is-checked');
    });
});

// flatten object by concatting values
function concatValues( obj ) {
    var value = '';
    for ( var prop in obj ) {
        value += obj[ prop ];
    }
    return value;
}
