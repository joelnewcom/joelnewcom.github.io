---
title: Hacking
layout: single
classes: wide
permalink: /hacking/
---
CTF write-ups, TryHackMe, HackTheBox, Hackvent and other security adventures.

{% assign hacking_entries = site.hacking | where_exp: "item", "item.hidden != true" | sort: "title" %}
<div class="entries-grid">
{% for entry in hacking_entries %}
  <div class="grid__item">
    <article class="archive__item" itemscope itemtype="https://schema.org/CreativeWork">
      {% if entry.header.teaser %}
      <div class="archive__item-teaser">
        <img src="{{ entry.header.teaser | relative_url }}" alt="">
      </div>
      {% endif %}
      <h2 class="archive__item-title no_toc" itemprop="headline">
        <a href="{{ entry.url | relative_url }}" rel="permalink">{{ entry.title }}</a>
      </h2>
      {% if entry.excerpt %}
      <p class="archive__item-excerpt" itemprop="description">{{ entry.excerpt | markdownify | strip_html | truncate: 160 }}</p>
      {% endif %}
    </article>
  </div>
{% endfor %}
</div>
