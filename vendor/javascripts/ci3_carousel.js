/* ========================================================================
 * cib_carousel.js v1.0
 * https://github.com/nhu313/cib_carousel
 * ========================================================================
 * Copyright 2015 - Infinity and beyond Nhu Nguyen
 * Licensed under MIT (https://github.com/nhu313/cib_carousel/blob/master/LICENSE)
 * ======================================================================== */
(function ($) {
  "use strict";

  var timer;

  function replaceClass(element, oldClass, newClass) {
    element.removeClass(oldClass);
    element.addClass(newClass);
  }

  function clearRotatingFunc(element, className) {
    element.unbind("click");
    element.removeClass(className);
  }

  function nextItem(element) {
    var next = element.next();
    if (next.length) {
      return next;
    } else {
      return element.parent().find('.item:first');
    }    
  }

  function prevItem(element) {
    var prev = element.prev();
    if (prev.length) {
      return prev;
    } else {
      return element.parent().find('.item:last');
    }
  }

  function addClickEvent(carousel, elementName, settings) {
    var element = carousel.find('.' + elementName);
    element.click(function() {
      clearRotatingFunc(carousel.find('.next'), 'next');
      clearRotatingFunc(carousel.find('.prev'), 'prev');
      carousel.find('.active').removeClass('active');

      setClasses($(this));
      clearInterval(timer);
      setAutoRotate(carousel, settings);
      
      bindRotateEvent(carousel, settings);    
    });
  }

  function bindRotateEvent(carousel, settings) {
    addClickEvent(carousel, 'prev', settings);
    addClickEvent(carousel, 'next', settings);
  }

  function setClasses(element) {
    element.addClass('active');
    prevItem(element).addClass('prev');
    nextItem(element).addClass('next');    
  }

  function bind(carousel, settings) {
    setClasses(carousel.find('.item:first'));
    
    bindRotateEvent(carousel, settings);
    setAutoRotate(carousel, settings);
  }

  function setAutoRotate(carousel, settings) {
    if (settings.auto) {
      timer = setInterval(function () {
                            carousel.find('.next').click();
                          }, (settings.duration * 1000));
    }
  }

  $.fn.ci3 = function(options) {
    var settings = $.extend( {}, $.fn.ci3.defaults, options );
    return this.each(function() {
      bind($(this), settings);
    });
  };

  $.fn.ci3.defaults = {
    duration: 4,
    auto: true
  };
  
}(jQuery));