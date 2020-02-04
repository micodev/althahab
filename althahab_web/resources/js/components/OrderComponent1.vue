<template>
  <div class="card">
    <h5 class="card-header">
      جدول الطلبات
      <button
        v-on:click="refresh"
        type="button"
        class="btn btn-outline-primary float-right"
      >تحديث</button>
    </h5>

    <div class="card-body">
      <div class="table-responsive-md">
        <table class="table table-bordered">
          <thead class="thead-dark">
            <tr>
              <th scope="col">رقم التوصيل</th>
              <th scope="col">رقم الزبون</th>
              <th scope="col">سعر الطلب</th>
              <th scope="col">الحالة</th>
              <th scope="col">تاريخ الطلب</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="order in orders" :key="order.id" v-bind="order">
              <th scope="row">{{ order.id }}</th>
              <td>{{ order.customer_number }}</td>
              <td>{{ order.cost }}</td>
              <td>
                <select
                  v-if="order.condition == 0"
                  class="custom-select custom-select-lg mb-3"
                  @change="updateSelected($event, order.id)"
                >
                  <option value="0" :selected="order.condition == 0">فعال</option>
                  <option value="1" :selected="order.condition == 1">واصل</option>
                  <option value="2" :selected="order.condition == 2">راجع</option>
                </select>
                <p v-else-if="order.condition == 1">واصل</p>
                <p v-else>راجع</p>
              </td>
              <!-- <td>{{ order.condition }}</td> -->
              <td>{{ order.created_at }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      api: "http://127.0.0.1:8000",
      orders: null,
      loading: true,
      errored: false
    };
  },
  mounted() {
    this.refresh();
  },
  methods: {
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
      this.orders = null;
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
