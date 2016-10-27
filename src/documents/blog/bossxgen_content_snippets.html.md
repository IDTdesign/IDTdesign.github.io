---
layout: article
title: BOSSXGEN Content Snippets
tags:
  - boss-revolution
  - manual
  - development
author: Paul Radzkov
date: October 21, 2016
---

# Content Snippets for BOSSXGEN

## Banner filenames

Template for naming files:

* `US-ENG_br-club_1000x80.png` (large)
* `US-ENG_br-club_500x120.png` (small)

where

* `US-ENG` is "Culture-Language": US-SPA, UK-ENG, DE-GER etc
* `br-club` — banner name. Any short name
* `_1000x80` or `_500x120` — size of banner. Also known as "large" and "small"
* `.png` or `.jpg` or `.gif` — pick format that provide smaller file size.

## Resources in CMS

CMS short codes:

* <code><del>[[Image:cubaspanish]]</del></code> —  **(deprecated)** insert an image from CMS.
* <code><del>[[File:yiptvbanner]]</del></code> — **(deprecated)** insert an image url from CMS.
* `[[Resource:yiptvbanner]]` — insert an image url from CMS.
* `[[Attachment:yiptvbannerpdf]]` — insert a link to attachement (pdf, doc, zip).

## Splash page banners

![](https://habrastorage.org/files/38c/ba8/c87/38cba8c87fdd4546aa41e08f7c61f0fe.png)

Single banner:

```html
<div class="item active">
    <a href="[[Attachment:yiptvbannerpdf]]">
        <img src="[[Resource:yiptvbanner]]" alt="Example banner"/>
    </a>
</div>

```

Two and more banners automatically activate caroucel:

```html
<div class="item active">
    <a href="[[Attachment:yiptvbannerpdf]]">
        <img src="[[Resource:yiptvbanner]]" alt="Example banner"/>
    </a>
</div>
<div class="item">
    <a href="[[Attachment:yiptvbannerpdf]]">
        <img src="[[Resource:yiptvbanner]]" alt="Example banner"/>
    </a>
</div>
```

First `.item` should always have class `.active`.

## Responsive Splash banners

Since Splash page has two columns we need four states for banners to best fit:

```html
<div class="item active">
    <a href="[[Attachment:BRClubEnglishFlyer]]" target="_blank">
        <picture>
            <source media="(min-width:1200px)" srcset="[[Resource:BRClubBannerEnglishLarge]]">
            <source media="(min-width:992px)"  srcset="[[Resource:BRClubBannerEnglishSmall]]">
            <source media="(min-width:768px)"  srcset="[[Resource:BRClubBannerEnglishLarge]]">
            <img src="[[Resource:BRClubBannerEnglishSmall]]" alt="Example banner">
        </picture>
    </a>
</div>
```

## Product page banner

![](https://habrastorage.org/files/245/503/ba8/245503ba874c4bc5a111c57a7941e477.png)

```html
<div class="banner banner-top">
    <a href="[[Attachment:yiptvbannerpdf]]">
        <img src="[[Resource:yiptvbanner]]" border="0/">
    </a>
</div>
```

## Product page responsive banner (with two sizes):

```html
<div class="banner banner-top">
    <a href="[[Attachment:BRClubEnglishFlyer]]" target="_blank">
        <picture>
            <source media="(min-width:992px)" srcset="[[Resource:BRClubBannerEnglishLarge]]">
            <img src="[[Resource:BRClubBannerEnglishSmall]]" alt="Example banner">
        </picture>
    </a>
</div>
```

## Product page slider

```html
<div id="prodpage-slider" class="carousel carousel-default slide" data-ride="carousel">
    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <a href="[[Attachment:CubacelAug2016ENG800PDF]]" target="_blank">
                <img src="[[Resource:CubacelAugust2016ENG800]]" border="0"/>
            </a>
        </div>
        <div class="item">
            <a href="[[Attachment:Tigo100PointBonusPromoFlyerEnglish]]" target="_blank">
                <img src="[[Resource:Tigo100PointBonusPromoBannerV3English]]" border="0"/>
            </a>
        </div>
    </div>
    <!-- end of Wrapper for slides -->
</div>
```

## Product page slider with arrows

```html
<div id="prodpage-slider" class="carousel carousel-default slide" data-ride="carousel">
    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <a href="[[Attachment:CubacelAug2016ENG800PDF]]" target="_blank">
                <img src="[[Resource:CubacelAugust2016ENG800]]" border="0"/>
            </a>
        </div>
        <div class="item">
            <a href="[[Attachment:Tigo100PointBonusPromoFlyerEnglish]]" target="_blank">
                <img src="[[Resource:Tigo100PointBonusPromoBannerV3English]]" border="0"/>
            </a>
        </div>
    </div>
    <!-- end of Wrapper for slides -->
    <!-- Controls -->
    <a class="left carousel-control" href="#prodpage-slider" role="button" data-slide="prev">
        <svg xmlns="http://www.w3.org/2000/svg" class="i i--slider-arrow-left">
            <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#i--slider-arrow-left"></use>
        </svg>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#prodpage-slider" role="button" data-slide="next">
        <svg xmlns="http://www.w3.org/2000/svg" class="i i--slider-arrow-right">
            <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#i--slider-arrow-right"></use>
        </svg>
        <span class="sr-only">Next</span>
    </a>
</div>
```

## Product page slider with arrows and responsive banners inside

```html
<div id="prodpage-slider" class="carousel carousel-default slide" data-ride="carousel">
    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <a href="[[Attachment:BRClubEnglishFlyer]]" target="_blank">
                <picture>
                    <source media="(min-width:992px)" srcset="[[Resource:BRClubBannerEnglishLarge]]">
                    <img src="[[Resource:BRClubBannerEnglishSmall]]" alt="Example banner">
                </picture>
            </a>
        </div>
        <div class="item">
            <a href="[[Attachment:Tigo100PointBonusPromoFlyerEnglish]]" target="_blank">
                <picture>
                    <source media="(min-width:992px)" srcset="[[Resource:Tigo100PointBonusPromoBannerV3EnglishLarge]]">
                    <img src="[[Resource:Tigo100PointBonusPromoBannerV3EnglishSmall]]" alt="Example banner">
                </picture>
            </a>
        </div>
    </div>
    <!-- end of Wrapper for slides -->
    <!-- Controls -->
    <a class="left carousel-control" href="#prodpage-slider" role="button" data-slide="prev">
        <svg xmlns="http://www.w3.org/2000/svg" class="i i--slider-arrow-left">
            <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#i--slider-arrow-left"></use>
        </svg>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#prodpage-slider" role="button" data-slide="next">
        <svg xmlns="http://www.w3.org/2000/svg" class="i i--slider-arrow-right">
            <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#i--slider-arrow-right"></use>
        </svg>
        <span class="sr-only">Next</span>
    </a>
</div>
```

## Contest

![](https://habrastorage.org/files/65a/561/32d/65a56132d7b5407682e9a2a9a753f8ff.png)

Contest markup with styles:

```html
<div class="contest-content blockrow">
    <div class="blockrow--col contest-details contest-data3">
        <h4>MONEY TRANSFER</h4>
        <p>SUMMER PROMOTIONS</p>
        <p><strong>EARN $3</strong> <small>ON EVERY TRANSFER LARGER THAN $100</small></p>
    </div>
    <div class="blockrow--col contest-data1">
        Transaction to date
        <strong class="contest-output contest-output-big">1500</strong>
    </div>
    <div class="blockrow--col contest-data2">
        Bonus to date
        <strong class="contest-output contest-output-big">$25500</strong>
    </div>
</div>

<style>
.contest-content {
  font-size: 12px;
  margin: 0;
}
.contest-content h1,
.contest-content h2,
.contest-content h3,
.contest-content h4,
.contest-content h5,
.contest-content h6,
.contest-content p,
.contest-content ul,
.contest-content ol {
  margin: 4px 0;
}
.contest-details,
.contest-data1,
.contest-data2 {
  padding: 10px;
  text-align: center;
  vertical-align: middle !important;
}
.contest-data1,
.contest-data2 {
  width: 25%;
}
.contest-data3 {
  color: #FFF;
  background: #01b000;
}
.contest-data1 {
  color: #FFF;
  background: #555;
}
.contest-data2 {
  color: #333;
  background: #ddd;
}
.contest-output {
  display: block;
}
.contest-output-big {
  font-size: 200%;
}
</style>
```

## Alignment classes

Can be used on block-level elements: `p`, `div`, `h1`.

```html
<p class="text-left">Left aligned text.</p>
<p class="text-center">Center aligned text.</p>
<p class="text-right">Right aligned text.</p>
<p class="text-justify">Justified text.</p>
<p class="text-nowrap">No wrap text.</p>
```

## Transformation classes

Can be used on any elements: `p`, `div`, `h1`, `a`, `span`.

```html
<p class="text-lowercase">Lowercased text.</p>
<p class="text-uppercase">Uppercased text.</p>
<p class="text-capitalize">Capitalized text.</p>
```

<p class="text-muted">An older version of this manual available on http://codepen.io/paulradzkov/full/XKRqYd/</p>
