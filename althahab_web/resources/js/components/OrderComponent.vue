<template>
  <div class="card">
    <h5 class="card-header">
      جدول الطلبات
      <div
        class="btn-group float-right"
        role="group"
        aria-label="Basic example"
        style="direction:ltr"
      >
        <button type="button" v-on:click="refresh" class="btn btn-outline-primary">تحديث</button>
        <button type="button" v-on:click="deleteweek" class="btn btn-outline-secondary">مسح اخر سبوع</button>
      </div>
    </h5>

    <div class="card-body">
      <div class="table-responsive-md">
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <span class="input-group-text" id="basic-addon1">رقم الوصل</span>
          </div>
          <input type="text" v-model="search" placeholder="1999813326" style="text-align:center" />
        </div>
        <table class="table table-bordered">
          <thead class="thead-dark">
            <tr>
              <th scope="col">رقم الوصل</th>
              <th scope="col">رقم الزبون</th>
              <th scope="col">سعر الطلب</th>
              <th scope="col">الحالة</th>
              <th scope="col">تاريخ الطلب</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="row in rows" :key="row.id">
              <td v-for="col in cols" :key="col">
                <p v-if="col!='condition'">{{ row[col]}}</p>
                <div v-else>
                  <select
                    v-if="row[col] == 0"
                    class="custom-select custom-select-lg mb-3"
                    @change="updateSelected($event, row.id)"
                  >
                    <option value="0" :selected="row[col] == 0">فعال</option>
                    <option value="1" :selected="row[col] == 1">واصل</option>
                    <option value="2" :selected="row[col] == 2">راجع</option>
                  </select>
                  <p v-else-if="row[col] == 1">واصل</p>
                  <p v-else>راجع</p>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  beforeMount() {
    this.refresh();
  },
  data() {
    return {
      api: "http://34.82.1.171", //"http://192.168.0.100:8000",
      orders: [],
      loading: true,
      search: null,
      column: "checkId",
      errored: false
    };
  },
  mounted() {
    // this.refresh();
  },
  computed: {
    cols() {
      let keys = this.orders.length >= 1 ? Object.keys(this.orders[0]) : [];
      console.log(keys);
      keys.splice(0, 1);
      return keys;
    },
    rows() {
      if (!this.orders.length) {
        return [];
      }

      return this.orders.filter(item => {
        let props =
          this.search && this.column
            ? [item[this.column]]
            : Object.values(item);

        return props.some(
          prop =>
            !this.search ||
            (typeof prop === "string"
              ? prop.includes(this.search)
              : prop.toString(10).includes(this.search))
        );
      });
    }
  },

  methods: {
    deleteweek: function() {
      axios
        .get(this.api + "/api/deleteOrders")
        .then(response => {
          this.refresh();
        })
        .catch(error => {
          console.log(error);
          this.errored = true;
        })
        .finally(function() {
          // this.loading = false;
        });
    },
    refresh: function() {
      axios
        .get(this.api + "/api/order")
        .then(response => {
          this.orders = response.data;
        })
        .catch(error => {
          console.log(error);
          this.errored = true;
        })
        .finally(function() {
          // this.loading = false;
        });
    },

    updateSelected: function(event, orderId) {
      this.change(orderId, event.target.value);
      //console.log(orderId + " : " + event.target.value);
    },
    change: function(orderId, condition) {
      this.orders = [];
      axios
        .get(
          this.api +
            "/api/changeOrder?orderId=" +
            orderId +
            "&cond=" +
            condition
        )
        .then(response => {
          this.refresh();
        })
        .catch(error => {
          console.log(error);
          this.errored = true;
        })
        .finally(function() {
          // this.loading = false;
        });
    }
  }
};
</script>
