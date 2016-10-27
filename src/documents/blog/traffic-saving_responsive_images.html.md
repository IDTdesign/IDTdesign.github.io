---
layout: article
title: Traffic-saving Responsive Images
tags:
  - development
  - manual
author: Paul Radzkov
date: October 20, 2016
styles:
    'traffic-saving_responsive_images/visibility.css'
---

# Traffic-saving Responsive Images

This is simple image:

```html
<img src="//placehold.it/960x240.png" alt="" />
```

<figure>
    <img src="//placehold.it/960x240.png" alt="" />
</figure>

To make it responsive we usually write some css:

```css
img {
  max-width: 100%;
}
```

But on small screens we aren't able to see all the details. We might want to use smaller image.

## The old way

When we need different content depending on screen sizes we have to insert separate `img` tag for every image and apply css classes that show or hide image depending of screen size:

```html
<img src="//placehold.it/320x158.png" alt="mobile image"  class="visible-xs-inline" />
<img src="//placehold.it/600x158.png" alt="tablet image"  class="visible-sm-inline" />
<img src="//placehold.it/960x240.png" alt="desktop image" class="visible-md-inline visible-lg-inline"  />
```

<figure>
    <img src="//placehold.it/320x158.png" alt="mobile image"  class="visible-xs-inline" />
    <img src="//placehold.it/600x158.png" alt="tablet image"  class="visible-sm-inline" />
    <img src="//placehold.it/960x240.png" alt="desktop image" class="visible-md-inline visible-lg-inline"  />
</figure>

**Advantages:**

* Simple well-known technique.
* 97.34% browser support on Oct 2016. [http://caniuse.com/#feat=css-mediaqueries](http://caniuse.com/#feat=css-mediaqueries)
* Image switches instantly when resizing viewport.

**Limitations:**

* Semantically this is three images. It also affects SEO.
* Browser makes all three requests and show only one image according current media rule. Two unnecessary images already downloaded.
* Content and representation are mixed: breakpoints in CSS, urls in HTML. Something may be broken if we try to use this content on different site.
* If CSS fails to load we see all three images.

Mobile users loads all ‘tablet’ and ‘desktop’ graphics and newer use it. The more image versions we have the more traffic we use.

## The new way

There is new `picture` element to solve the problem:

```html
<picture>
    <source media="(min-width:992px)" srcset="//placehold.it/960x240.png">
    <source media="(min-width:768px)" srcset="//placehold.it/600x158.png">
    <img src="//placehold.it/320x158.png" alt="">
</picture>
```
<figure>
    <picture>
        <source media="(min-width:992px)" srcset="//placehold.it/960x240.png">
        <source media="(min-width:768px)" srcset="//placehold.it/600x158.png">
        <img src="//placehold.it/320x158.png" alt="">
    </picture>
</figure>

This is ‘mobile first’ approach when we fall back to old `img` tag with the smallest image inside. Old browsers that doesn't understand `picture` and `sourse` tags see only `img` element.

We may reverse the logic to ‘desktop first’ approach:

```html
<picture>
    <source media="(max-width:768px)" srcset="//placehold.it/320x158.png">
    <source media="(max-width:992px)" srcset="//placehold.it/600x158.png">
    <img src="//placehold.it/960x240.png" alt="">
</picture>
```

<figure>
    <picture>
        <source media="(max-width:768px)" srcset="//placehold.it/320x158.png">
        <source media="(max-width:992px)" srcset="//placehold.it/600x158.png">
        <img src="//placehold.it/960x240.png" alt="">
    </picture>
</figure>

**Advantages:**

* Semantically this is one image with multiple representations.
* Browser makes one requests according current media rule. When (if) screen size changes browser make additional request.
* Image media rules are not connected to css. Content well transferrable between different sites.
* If CSS fails to load we see only one correct image.

**Limitations:**

* 72.57% browser support on Oct 2016. [http://caniuse.com/#search=picture](http://caniuse.com/#search=picture)
* Images switches not immediately on resize (seen on slow connections).

## Upgrade to ‘retina’ images

For devices with high-definition screens we can add additional set of pictures exported @2x.

```html
<picture>
    <source media="(min-width:992px)" srcset="
        //placehold.it/960x240.png 1x,
        //placehold.it/1920x480.png?text=960x240@2x 2x
    ">
    <source media="(min-width:768px)" srcset="
        //placehold.it/600x158.png 1x,
        //placehold.it/1200x316.png?text=600x158@2x 2x
    ">
    <img srcset="//placehold.it/640x316.png?text=320x158@2x 2x"
         src="//placehold.it/320x158.png" alt="">
</picture>
```

<figure>
    <picture>
        <source media="(min-width:992px)" srcset="//placehold.it/960x240.png 1x, //placehold.it/1920x480.png?text=960x240@2x 2x">
        <source media="(min-width:768px)" srcset="//placehold.it/600x158.png 1x, //placehold.it/1200x316.png?text=600x158@2x 2x">
        <img srcset="//placehold.it/640x316.png?text=320x158@2x 2x" src="//placehold.it/320x158.png" alt="">
    </picture>
</figure>

Modern browsers that support `srcset` natively may select a cached file that meets the minimum media condition, even if it is “overkill” for the current media condition. For example, a **2x** file may be shown on a **1x** device, if that **2x** file is already in the cache — there’d be no reason to make an additional request when the user will see no discernable difference, after all. This is typically encountered only on sites with multiple versions of the same image displayed in multiple elements at different sizes. The occasional selection of "oversize" resources — depending on the cache — is currently an expected behavior in native implementations and you may encounter it during testing.
