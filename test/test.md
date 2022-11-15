---
title: Test rendering
permalink: /
layout: single
---


## include raw

<pre>
{% raw %}
{% highlight javascript mark_lines="1 3" %}
{% include_snippet test/test2.md token="-- doc" do_not_escape %}
{% endhighlight %}
{% endraw %}
</pre>

{% highlight javascript mark_lines="1 3" %}
{% include_snippet test/test2.md token="-- doc" do_not_escape %}
{% endhighlight %}

<pre>
{% raw %}
{% highlight javascript mark_lines="1 3" %}
{% include_snippet test/test2.md token="-- doc" pre %}
{% endhighlight %}
{% endraw %}
</pre>

{% highlight javascript mark_lines="1 3" %}
{% include_snippet test/test2.md token="-- doc" pre %}
{% endhighlight %}

{% raw %}{% include_snippet test/test2.md token="-- doc" pre %} {% endraw %}
{% include_snippet test/test2.md token="-- doc" pre %}

{% raw %} {% include_snippet test/test2.md token="-- doc" %}{% endraw %}
{% include_snippet test/test2.md token="-- doc" %}

{% raw %} {% include_snippet test/test2.md token="-- doc" label=bob %}{% endraw %}
{% include_snippet test/test2.md token="-- doc" label=bob %}

{% raw %} {% include_snippet test/test2.md label=bob %}{% endraw %}
{% include_snippet test/test2.md label=bob %}

## Flexible include

{% raw %} {% flexible_include test/test2.md %} {% endraw %}
{% flexible_include test/test2.md %}

{% raw %} {% flexible_include test/test2.md label=bob%} {% endraw %}
{% flexible_include test/test2.md label=bob %}


### Copy Button (Broken) 
{% raw %} {% flexible_include test/test2.md copyButton %} {% endraw %}
{% flexible_include test/test2.md copyButton %}

Using markdown:
```markdown
{% flexible_include test/test2.md do_not_escape %}
```

<pre>
{% raw %}
{% highlight markdown linenos %}
{% flexible_include test/test2.md %}
{% endhighlight %}
{% endraw %}
</pre>

{% highlight markdown linenos %}
{% flexible_include test/test2.md %}
{% endhighlight %}
