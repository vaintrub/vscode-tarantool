---@meta
--luacheck: ignore

local metrics = {}

---Enable default Tarantool metrics such as network, memory, operations, etc.
---
--- **Default metric names:**
---
--- network, operations, system, replicas, info, slab, runtime, memory, event_loop,
---
--- spaces, fibers, cpu, vinyl, memtx, luajit, cartridge_issues, cartridge_failover, clock
---@param include string[]? table containing the names of the default metrics that you need to enable.
---@param exclude string[]? table containing the names of the default metrics that you need to exclude.
function metrics.enable_default_metrics(include, exclude) end


--- All collectors support providing label_pairs on data modification. A label is a piece of metainfo that you associate with a metric in the key-value format. See tags in Graphite and labels in Prometheus. Labels are used to differentiate between the characteristics of a thing being measured. For example, in a metric associated with the total number of HTTP requests, you can represent methods and statuses as label pairs:
---
--- http_requests_total_counter:inc(1, {method = 'POST', status = '200'})
--- You don’t have to predefine labels in advance.
---
--- With labels, you can extract new time series (visualize their graphs) by specifying conditions with regard to label values. The example above allows extracting the following time series:
---
--- The total number of requests over time with method = "POST" (and any status).
--- The total number of requests over time with status = 500 (and any method).
--- You can also set global labels by calling metrics.set_global_labels({ label = value, ...})
---@alias label_pairs table<string,string>

---Set the global labels to be added to every observation.
---
--- Global labels are applied only to metric collection. They have no effect on how observations are stored.
---
--- Global labels can be changed on the fly.
---
---label_pairs from observation objects have priority over global labels. If you pass label_pairs to an observation method with the same key as some global label, the method argument value will be used.
---
-- **Note** that both label names and values in label_pairs are treated as strings.
---@param label_pairs label_pairs
function metrics.set_global_labels(label_pairs) end




---@class Counter
local counter_obj = {}

---Register a new counter
---@param name string collector name. Must be unique.
---@param help string? collector description.
---@return Counter
function metrics.counter(name, help) end


---Increment the observation for label_pairs. If label_pairs doesn’t exist, the method creates it.
---@param num number increment value.
---@param label_pairs label_pairs table containing label names as keys, label values as values. Note that both label names and values in label_pairs are treated as strings.
function counter_obj:inc(num, label_pairs) end


---@class ObservationObj
---@field label_pairs label_pairs `label_pairs` key-value table
---@field timestamp uint64_t current system time (in microseconds)
---@field value number current value
---@field metric_name string collector


---Returns an array of observation objects for a given counter.
---@return ObservationObj[]
function counter_obj:collect() end


---Remove the observation for label_pairs.
---@param label_pairs label_pairs table containing label names as keys, label values as values. Note that both label names and values in label_pairs are treated as strings.
function counter_obj:remove(label_pairs) end

---Set the observation for label_pairs to 0.
---@param label_pairs label_pairs table containing label names as keys, label values as values. Note that both label names and values in label_pairs are treated as strings.
function counter_obj:reset(label_pairs) end



---@class Gauge
local gauge_obj = {}


---Register a new gauge.
---@param name string collector name. Must be unique.
---@param help string? collector description.
---@return Gauge A gauge object.
function metrics.gauge(name, help) end


---Increment the observation for label_pairs. If label_pairs doesn’t exist, the method creates it.
---@param num number increment value.
---@param label_pairs label_pairs table containing label names as keys, label values as values. Note that both label names and values in label_pairs are treated as strings.
function gauge_obj:inc(num, label_pairs) end

---Decrement the observation for label_pairs. If label_pairs doesn’t exist, the method creates it.
---@param num number Decrement value.
---@param label_pairs label_pairs table containing label names as keys, label values as values. Note that both label names and values in label_pairs are treated as strings.
function gauge_obj:dec(num, label_pairs) end


---Sets the observation for label_pairs to num.
---@param num number set value.
---@param label_pairs label_pairs table containing label names as keys, label values as values. Note that both label names and values in label_pairs are treated as strings.
function gauge_obj:set(num, label_pairs) end

---Returns an array of observation objects for a given gauge.
---@return ObservationObj[]
function gauge_obj:collect() end

---Remove the observation for label_pairs.
---@param label_pairs label_pairs table containing label names as keys, label values as values. Note that both label names and values in label_pairs are treated as strings.
function gauge_obj:remove(label_pairs) end


---Register a new histogram.
---@param name string collector name. Must be unique.
---@param help? string collector description.
---@param buckets? number[] histogram buckets (an array of sorted positive numbers). The infinity bucket (INF) is appended automatically. Default: {.005, .01, .025, .05, .075, .1, .25, .5, .75, 1.0, 2.5, 5.0, 7.5, 10.0, INF}.
function metrics.histogram(name, help, buckets) end


---A histogram is basically a set of collectors:
---
---name .. "_sum" – a counter holding the sum of added observations.
---
---name .. "_count" – a counter holding the number of added observations.
---
---name .. "_bucket" – a counter holding all bucket sizes under the label le (less or equal). To access a specific bucket – x (where x is a number), specify the value x for the label.
---@class Histogram
local histogram_obj = {}


---Record a new value in a histogram. This increments all bucket sizes under the labels le >= num and the labels that match label_pairs.
---@param num number value to put in the histogram.
---@param label_pairs label_pairs table containing label names as keys, label values as values. All internal counters that have these labels specified observe new counter values. Note that both label names and values in label_pairs are treated as strings.
function histogram_obj:observe(num, label_pairs) end

---Return a concatenation of counter_obj:collect() across all internal counters of histogram_obj.
---@return ObservationObj[]
function histogram_obj:collect() end

---Remove the observation for label_pairs.
---@param label_pairs label_pairs table containing label names as keys, label values as values. Note that both label names and values in label_pairs are treated as strings.
function histogram_obj:remove(label_pairs) end


---Register a new summary. Quantile computation is based on the «Effective computation of biased quantiles over data streams» algorithm.
---@param name string сollector name. Must be unique
---@param help string? collector description
---@param objectives table<number,number>? a list of «targeted» φ-quantiles in the {quantile = error, ... } form. Example: {[0.5]=0.01, [0.9]=0.01, [0.99]=0.01}. The targeted φ-quantile is specified in the form of a φ-quantile and the tolerated error. For example, {[0.5] = 0.1} means that the median (= 50th percentile) is to be returned with a 10-percent error. Note that percentiles and quantiles are the same concept, except that percentiles are expressed as percentages. The φ-quantile must be in the interval [0, 1]. A lower tolerated error for a φ-quantile results in higher memory and CPU usage during summary calculation.
---@param params table? table of the summary parameters used to configuring the sliding time window. This window consists of several buckets to store observations. New observations are added to each bucket. After a time period, the head bucket (from which observations are collected) is reset, and the next bucket becomes the new head. This way, each bucket stores observations for max_age_time * age_buckets_count seconds before it is reset. max_age_time sets the duration of each bucket’s lifetime – that is, how many seconds the observations are kept before they are discarded. age_buckets_count sets the number of buckets in the sliding time window. This variable determines the number of buckets used to exclude observations older than max_age_time from the summary. The value is a trade-off between resources (memory and CPU for maintaining the bucket) and how smooth the time window moves. Default value: {max_age_time = math.huge, age_buckets_count = 1}.
---@return SummaryObj
function metrics.summary(name, help, objectives, params) end


--- **A summary represents a set of collectors:**
---
---name .. "_sum" – a counter holding the sum of added observations.
---
---name .. "_count" – a counter holding the number of added observations.
---
---name holds all the quantiles under observation that find themselves under the label quantile (less or equal). To access bucket x (where x is a number), specify the value x for the label quantile.
---object summary_obj
---@class SummaryObj
local summary_obj = {}



--- Record a new value in a summary.
---@param num number value to put in the data stream
---@param label_pairs label_pairs a table containing label names as keys, label values as values. All internal counters that have these labels specified observe new counter values. You can’t add the "quantile" label to a summary. It is added automatically. If max_age_time and age_buckets_count are set, the observed value is added to each bucket. Note that both label names and values in label_pairs are treated as strings.
function summary_obj:observe(num, label_pairs) end


--- Return a concatenation of counter_obj:collect() across all internal counters of summary_obj. For the description of observation, see counter_obj:collect(). If max_age_time and age_buckets_count are set, quantile observations are collected only from the head bucket in the sliding time window, not from every bucket. If no observations were recorded, the method will return NaN in the values.
---@return ObservationObj
function summary_obj:collect() end


---Remove the observation for label_pairs.
---@param label_pairs label_pairs table containing label names as keys, label values as values. Note that both label names and values in label_pairs are treated as strings.
function summary_obj:remove(label_pairs) end


return metrics
