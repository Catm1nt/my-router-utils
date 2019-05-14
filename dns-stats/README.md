DNS Stats Collector
=======
A small utility for collecting stats on the most common DNS servers. It currently monitors the following servers in this order:
1. [Google's Public DNS](https://en.wikipedia.org/wiki/Google_Public_DNS).
2. [IBM's Quad9](https://en.wikipedia.org/wiki/Quad9).
3. [Cisco's OpenDNS](https://en.wikipedia.org/wiki/OpenDNS).
4. [CloudFlare's 1.1.1.1](https://en.wikipedia.org/wiki/1.1.1.1)

Every 60 seconds, the utility logs two values for each server:
1. Average latency of 5 ICMP pings. The reason for doing the ICMP probe is to give the possibility minimise the penalty of networking issues on my end or on my ISP's end when making the final calculations.
2. Average DNS resolution time of 5 randomly picked domains from `top-20k.txt`, queried consecutively. The reason for randomly picking out of a large collection is to minimise the effect of caching due to the chronological proximity of the discrete tests.

The `top-20k.txt` file is a collection of top 20 thousand 2LD domain names out of [Cisco Umbrella Top 1 Million list](https://umbrella.cisco.com/blog/2016/12/14/cisco-umbrella-1-million/).