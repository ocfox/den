---
title: "不要怀疑网线"
date: "2024-02-07"
tags: ["network", "life"]
---

### 什么? Gigabit网络接口只有300Mbps?

就因为装修工用了不存在的`Cat 6e`[^1]网线, 1Gbps 的接口变成了甚至不到 300Mbps ?
这不可能（除非~~你离我家有几千公里~~你真的用了一整卷网线）。
虽然他是假的网线但应该也会有高于Cat5的水平吧 我猜。

```sh
# 两个朋友通过墙里的线缆联系
[ ID]   Interval          Transfer    Bitrate
[  7]   0.00-10.00  sec   364 MBytes   306 Mbits/sec     sender
[  7]   0.00-10.01  sec   361 MBytes   303 Mbits/sec     receiver
```
看起来他们的沟通出现了一些问题，好吧 让我把他们放在一起。

```sh
# 两个朋友面对面联系
[ ID]   Interval          Transfer    Bitrate
[  8]   0.00-10.00  sec   376 MBytes   310 Mbits/sec     sender
[  8]   0.00-10.01  sec   383 MBytes   312 Mbits/sec     receiver
```
还不如无线啊你们这个关系。难道是我mac有问题？怎么可能，估计是网卡有问题吧。
<details>
  <summary>(你可以嘲笑mac用户了，他们甚至没有RJ45)</summary>
  那又怎么样，我还是很喜欢我的mac。在某种程度上
</details>

正好有另一个网卡，尝试！**我去，居然完全正常！**
{{< figure src="https://cdn.firstcuriosity.com/wp-content/uploads/2022/11/07212640/Adobe_Express_20221107_2117220_1.jpg"
 width="300" align="center" >}}

原因竟然是我那条cc数据线速度很慢。好了，这就是我做的蠢事。

```sh
[ ID] Interval           Transfer     Bitrate
[  9]   0.00-10.00  sec   982 MBytes   823 Mbits/sec                  sender
[  9]   0.00-10.01  sec   979 MBytes   821 Mbits/sec                  receiver
```
最后就是这个情况，好吧，线还是很烂。但至少我一周前接的没有问题。
(这是我上一周将家里装修工留下的线接了水晶头。一共三组 三个墙上插座，三个水晶头。
100%成功率。我应该也算是接线大师了？)

如果你看到这句话，说明你赚到了1分钟！看到这么~~有趣~~的事情完全不算浪费时间对吧。

[^1]: 这个世界上没有Cat6e这样的标准，如果你用的也是Cat6e，恭喜你中奖了。
