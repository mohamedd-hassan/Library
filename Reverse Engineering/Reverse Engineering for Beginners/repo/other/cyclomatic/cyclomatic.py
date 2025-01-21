# Calculating cyclomatic complexity for all functions in all segments.
# See also: https://yurichev.com/blog/cyclomatic
# by Dennis@Yurichev.com

import idaapi

# based on ex_gdl_qflow_chart.py from examples
def process_func(ea):
    f = idaapi.get_func(ea)
    if not f:
        return
    rets=0
    edges=0
        
    q = idaapi.qflow_chart_t("The title", f, 0, 0, idaapi.FC_PREDS)
    for n in xrange(0, q.size()):
        if q.is_ret_block(n):
            rets=rets+1
        else:
            edges=edges+q.nsucc(n)
                
    nodes=q.size()
    print "%x %s edges=%d nodes=%d rets=%d E-N+2=%d E-N+rets=%d" % (ea, GetFunctionName(ea), edges, nodes, rets, edges-nodes+2, edges-nodes+rets)

#process_func(here())

for ea in Segments():
    for funcea in Functions(SegStart(ea), SegEnd(ea)):
        process_func(funcea)
