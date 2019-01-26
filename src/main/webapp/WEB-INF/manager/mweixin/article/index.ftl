<!-- 新建图文 -->
<script src="//cdnjs.cloudflare.com/ajax/libs/vue/2.5.2/vue.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sortablejs@1.7.0/Sortable.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/Vue.Draggable/2.17.0/vuedraggable.min.js"></script>
<!-- v-if="menuVue.menuActive == '新建图文'" -->
<div id='article'>
    <el-container>
        <el-aside width="280px">
            <draggable v-model="myArray" :options="{draggable:'.item'}">
                <div v-for="element in myArray" :key="element.id" class="item">
                    {{element.name}}
                </div>
                <button slot="footer" @click="addPeople">Add</button>
            </draggable>
        </el-aside>
        <el-main>Main</el-main>
    </el-container>
</div>
<script>
    var articleVue = new Vue({
        el: '#article',
        data:{
            myArray:[{
                name:'染发个人',
                id:'001100'
            },{
                name:'个问题grew',
                id:'001100'
            },{
                name:'跟他玩过任务',
                id:'001100'
            },{
                name:'供热外国人',
                id:'001100'
            },{
                name:'天文台认为',
                id:'001100'
            }]
        },
        watch:{
            myArray:function(n,o){
                console.log('n',n);
            }
        },
        methods:{
            addPeople:function(){

            }
        }
    })
</script>